<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DataTables\SubAdminDataTable;
use App\Models\User;
use App\Helpers\AuthHelper;
use App\Models\Role;
use App\Http\Requests\SubAdminRequest;

class SubAdminController extends Controller
{
    public function index(SubAdminDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',[ 'form' => __('message.sub_admin') ] );
        $auth_user = AuthHelper::authSession();

        $assets = ['data-table'];
        
        $headerAction = '<a href="'.route('subadmin.create').'" class="btn btn-sm btn-primary" role="button">'.__('message.add_form_title', [ 'form' => __('message.sub_admin')]).'</a>';

        return $dataTable->render('global.datatable', compact('pageTitle', 'auth_user', 'assets', 'headerAction'));
    }

    public function create()
    {

        $assets = ['phone'];
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.sub_admin')]);
        $roles = Role::where('status', 1)->whereNotIn('name', ['user'])->get()->pluck('title', 'name');
        return view('sub_admin.form', compact('pageTitle','roles','assets'));
    }

    public function store(SubAdminRequest $request)
    {
        $request['password'] = bcrypt($request->password);

        $request['username'] = $request->username ?? stristr($request->email, "@", true) . rand(100,1000);
        $request['display_name'] = $request['first_name']." ".$request['last_name'];
        $sub_admin = User::create($request->all());

        storeMediaFile($sub_admin, $request->profile_image, 'profile_image');

        $sub_admin->assignRole($request->user_type);

        // Save Sub Admin Profile data...
        // $sub_admin->userProfile()->create($request->userProfile);

        return redirect()->route('subadmin.index')->withSuccess(__('message.save_form',['form' => __('message.sub_admin')]));
    }

    public function show($id)
    {
        
    }

    public function edit($id)
    {
        $data = User::findOrFail($id);

        $pageTitle = __('message.update_form_title',[ 'form' => __('message.sub_admin')]);
        $assets = ['phone'];
        $profileImage = getSingleMedia($data, 'profile_image');
        $roles = Role::where('status', 1)->whereNotIn('name', ['admin'])->get()->pluck('title', 'name');

        return view('sub_admin.form', compact('data', 'id', 'profileImage', 'pageTitle', 'roles','assets'));
    }

    public function update(SubAdminRequest $request, $id)
    {
        $sub_admin = User::with('userProfile')->findOrFail($id);      
        $request['display_name'] = $request['first_name']." ".$request['last_name'];
        $sub_admin->removeRole($sub_admin->user_type);
        
        // User user data..
        $sub_admin->fill($request->all())->update();

        $sub_admin->assignRole($request['user_type']);
        // Save user image...
        if (isset($request->profile_image) && $request->profile_image != null) {
            $sub_admin->clearMediaCollection('profile_image');
            $sub_admin->addMediaFromRequest('profile_image')->toMediaCollection('profile_image');
        }

        // user profile data....
        // $sub_admin->userProfile->fill($request->userProfile)->update();

        if(auth()->check()){
            return redirect()->route('subadmin.index')->withSuccess(__('message.update_form', ['form' => __('message.sub_admin')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form', ['form' => __('message.sub_admin')]));

    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.sub_admin')]);

        if($sub_admin != '') {
            $sub_admin->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.sub_admin')]);

        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message, 'datatable_reload' => 'dataTable_wrapper']);
        }

        return redirect()->back()->with($status,$message);

    }
}
