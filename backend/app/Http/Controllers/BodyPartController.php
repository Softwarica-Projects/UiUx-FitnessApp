<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DataTables\BodyPartDataTable;
use App\Helpers\AuthHelper;
use App\Models\BodyPart;

use App\Http\Requests\BodyPartRequest;

class BodyPartController extends Controller
{
    public function index(BodyPartDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.bodypart')] );
        $auth_user = AuthHelper::authSession();

        $assets = ['data-table'];

        $headerAction = '<a href="'.route('bodypart.create').'" class="btn btn-sm btn-primary" role="button">'.__('message.add_form_title', [ 'form' => __('message.bodypart')]).'</a>';

        return $dataTable->render('global.datatable', compact('pageTitle', 'auth_user', 'assets', 'headerAction'));
    }

    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.bodypart')]);

        return view('bodypart.form', compact('pageTitle'));
    }
    public function store(BodyPartRequest $request)
    {
        $bodypart = BodyPart::create($request->all());

        storeMediaFile($bodypart,$request->bodypart_image, 'bodypart_image'); 

        return redirect()->route('bodypart.index')->withSuccess(__('message.save_form', ['form' => __('message.bodypart')]));
    }

    public function show($id)
    {
        $data = BodyPart::findOrFail($id);
    }

    public function edit($id)
    {
        $data = BodyPart::findOrFail($id);
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.bodypart') ]);

        return view('bodypart.form', compact('data','id','pageTitle'));
    }

    public function update(BodyPartRequest $request, $id)
    {
        $bodypart = BodyPart::findOrFail($id);

        // bodypart data...
        $bodypart->fill($request->all())->update();

        // Save bodypart image...
        if (isset($request->bodypart_image) && $request->bodypart_image != null) {
            $bodypart->clearMediaCollection('bodypart_image');
            $bodypart->addMediaFromRequest('bodypart_image')->toMediaCollection('bodypart_image');
        }

        if(auth()->check()){
            return redirect()->route('bodypart.index')->withSuccess(__('message.update_form',['form' => __('message.bodypart')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.bodypart') ] ));

    }

    public function destroy($id)
    {
        $bodypart = BodyPart::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.bodypart')]);

        if($bodypart != '') {
            $bodypart->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.bodypart')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
