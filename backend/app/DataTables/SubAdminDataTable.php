<?php

namespace App\DataTables;

use App\Models\User;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;
use App\Traits\DataTableTrait;

class SubAdminDataTable extends DataTable
{
    use DataTableTrait;

    public function dataTable($query)
    {
        return datatables()
            ->eloquent($query)
            ->editColumn('userProfile.age', function($query) {
                return $query->userProfile->age ?? '-';
            })
            
            ->editColumn('status', function($query) {
                $status = 'warning';
                switch ($query->status) {
                    case 'active':
                        $status = 'primary';
                        break;
                    case 'inactive':
                        $status = 'danger';
                        break;
                    case 'banned':
                        $status = 'dark';
                        break;
                }
                return '<span class="text-capitalize badge bg-'.$status.'">'.$query->status.'</span>';
            })

            ->editColumn('created_at', function ($query) {
                return dateAgoFormate($query->created_at, true);
            })
            ->editColumn('updated_at', function ($query) {
                return dateAgoFormate($query->updated_at, true);
            })
            ->order(function ($query) {
                if (request()->has('order')) {
                    $order = request()->order[0];
                    $column_index = $order['column'];

                    $column_name = 'id';
                    $direction = 'desc';
                    if( $column_index != 0) {
                        $column_name = request()->columns[$column_index]['data'];
                        $direction = $order['dir'];
                    }
    
                    $query->orderBy($column_name, $direction);
                }
            })
            ->addColumn('action', 'sub_admin.action')
            ->rawColumns(['action','status']);
    }

    public function query()
    {
        $model = User::whereNotIn('user_type', ['user']);
        return $this->applyScopes($model);
    }

    protected function getColumns()
    {
        return [
            // ['data' => 'id', 'name' => 'id', 'title' =>  __('message.id')],
            ['data' => 'display_name', 'name' => 'display_name', 'title' => __('message.name')],
            ['data' => 'phone_number', 'name' => 'phone_number', 'title' => __('message.phone_number')],
            ['data' => 'email', 'name' => 'email', 'title' => __('message.email')],
            ['data' => 'status', 'name' => 'status', 'title' => __('message.status')], 
            ['data' => 'created_at', 'name' => 'created_at', 'title' => __('message.created_at')],
            ['data' => 'updated_at', 'name' => 'updated_at', 'title' => __('message.updated_at')],

            Column::computed('action')
                  ->exportable(false)
                  ->printable(false)
                  ->title(__('message.action'))
                  ->searchable(false)
                  ->width(60)
                  ->addClass('text-center hide-search'),
        ];
        
    }
}
