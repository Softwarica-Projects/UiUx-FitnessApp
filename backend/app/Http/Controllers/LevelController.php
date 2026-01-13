<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DataTables\LevelDataTable;
use App\Models\Level;
use App\Helpers\AuthHelper;

use App\Http\Requests\LevelRequest;

class LevelController extends Controller
{
    public function index(LevelDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.level')] );
        $auth_user = AuthHelper::authSession();
        $assets = ['data-table'];

        $headerAction = '<a href="'.route('level.create').'" class="btn btn-sm btn-primary" role="button">'.__('message.add_form_title', [ 'form' => __('message.level')]).'</a>';

        return $dataTable->render('global.datatable', compact('pageTitle', 'auth_user', 'assets', 'headerAction'));
    }

    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.level')]);

        return view('level.form', compact('pageTitle'));
    }

    public function store(LevelRequest $request)
    {
        $level = Level::create($request->all());

        storeMediaFile($level,$request->level_image, 'level_image'); 

        return redirect()->route('level.index')->withSuccess(__('message.save_form', ['form' => __('message.level')]));
    }

    public function show($id)
    {
        $data = Level::findOrFail($id);
    }

    public function edit($id)
    {
        $data = Level::findOrFail($id);
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.level') ]);

        return view('level.form', compact('data','id','pageTitle'));
    }

    public function update(LevelRequest $request, $id)
    {
        $level = Level::findOrFail($id);

        // level data...
        $level->fill($request->all())->update();

        // Save level image...
        if (isset($request->level_image) && $request->level_image != null) {
            $level->clearMediaCollection('level_image');
            $level->addMediaFromRequest('level_image')->toMediaCollection('level_image');
        }

        if(auth()->check()){
            return redirect()->route('level.index')->withSuccess(__('message.update_form',['form' => __('message.level')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.level') ] ));

    }

    public function destroy($id)
    {
        $level = Level::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.level')]);

        if($level != '') {
            $level->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.level')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
