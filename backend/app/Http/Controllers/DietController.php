<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DataTables\DietDataTable;
use App\Helpers\AuthHelper;
use App\Models\Diet;

use App\Http\Requests\DietRequest;


class DietController extends Controller
{
    public function index(DietDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.diet')] );
        $auth_user = AuthHelper::authSession();
        $assets = ['data-table'];

        $headerAction = '<a href="'.route('diet.create').'" class="btn btn-sm btn-primary" role="button">'.__('message.add_form_title', [ 'form' => __('message.diet')]).'</a>';

        return $dataTable->render('global.datatable', compact('pageTitle', 'auth_user', 'assets', 'headerAction'));
    }

    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.diet')]);

        return view('diet.form', compact('pageTitle'));
    }
    public function store(DietRequest $request)
    {
        $diet = Diet::create($request->all());

        storeMediaFile($diet,$request->diet_image, 'diet_image'); 

        return redirect()->route('diet.index')->withSuccess(__('message.save_form', ['form' => __('message.diet')]));
    }

    public function show($id)
    {
        $data = Diet::findOrFail($id);
    }

    public function edit($id)
    {
        $data = Diet::findOrFail($id);
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.diet') ]);

        return view('diet.form', compact('data','id','pageTitle'));
    }

    public function update(DietRequest $request, $id)
    {
        $diet = Diet::findOrFail($id);

        // diet data...
        $diet->fill($request->all())->update();

        // Save diet image...
        if (isset($request->diet_image) && $request->diet_image != null) {
            $diet->clearMediaCollection('diet_image');
            $diet->addMediaFromRequest('diet_image')->toMediaCollection('diet_image');
        }

        if(auth()->check()){
            return redirect()->route('diet.index')->withSuccess(__('message.update_form',['form' => __('message.diet')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.diet') ] ));

    }

    public function destroy($id)
    {
        $diet = Diet::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.diet')]);

        if($diet != '') {
            $diet->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.diet')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
