<?php

namespace App\Http\Controllers\Security;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Role;
use App\DataTables\RoleDataTable;
use App\Helpers\AuthHelper;

class RoleController extends Controller
{
    public function index(RoleDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.role')] );
        $auth_user = AuthHelper::authSession();
        $assets = ['data-table'];
        $headerAction  = '';
        if($auth_user->can('role-add')){
            $headerAction ='<a href="#" class="float-end btn btn-sm btn-primary" data-modal-form="form" data-size="small" data--href="'.route('permission.add',['type'=>'role']).'" data-app-title="'.__('message.add_form_title',['form' => __('message.role')]).'" data-placement="top">'.__('message.add_form_title',['form' => __('message.role')]).'</a>';
        }
        return $dataTable->render('role.index', compact('assets', 'pageTitle', 'headerAction', 'auth_user'));
    }

    public function create(Request $request)
    {
        $data = $request->all();
        $view = view('role-permission.form-role')->render();
        return response()->json(['data' =>  $view, 'status'=> true]);
    }

    public function store(Request $request)
    {
       //code here
    }

    public function show($id)
    {
       
    }

    public function edit($id)
    {
        
    }

    public function update(Request $request, $id)
    {
        
    }

    public function destroy($id)
    {
       //code here
    }
}
