<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DataTables\ClassScheduleDataTable;
use App\Models\ClassSchedule;
use App\Helpers\AuthHelper;

use App\Http\Requests\ClassScheduleRequest;
use Carbon\Carbon;

class ClassScheduleController extends Controller
{
    public function index(ClassScheduleDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.class_schedule')] );
        $auth_user = AuthHelper::authSession();
        $assets = ['data-table'];

        $headerAction = '<a href="'.route('classschedule.create').'" class="btn btn-sm btn-primary" role="button">'.__('message.add_form_title', [ 'form' => __('message.class_schedule')]).'</a>';

        return $dataTable->render('global.datatable', compact('pageTitle', 'auth_user', 'assets', 'headerAction'));
    }

    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.class_schedule')]);

        return view('class_schedule.form', compact('pageTitle'));
    }

    public function store(ClassScheduleRequest $request)
    {
        $data = $request->all();
        $data['workout_title'] = $request->workout_id == 'other' ? $request->workout_title : null;
        $data['workout_id'] = $request->workout_id != 'other' ? $request->workout_id : null;
        $data['workout_type'] = $request->workout_id == 'other' ? 'other' : 'workout';
        $data['start_time'] = Carbon::parse($request->start_time)->setTimezone('UTC')->toDateTimeString();
        $data['end_time'] = Carbon::parse($request->end_time)->setTimezone('UTC')->toDateTimeString();

        ClassSchedule::create($data);
        return redirect()->route('classschedule.index')->withSuccess(__('message.save_form', ['form' => __('message.class_schedule')]));
    }

    public function show($id)
    {
        $data = ClassSchedule::findOrFail($id);
    }

    public function edit($id)
    {
        $data = ClassSchedule::findOrFail($id);
        $workout_id = $data->workout_type == 'other' ? ['other' => __('message.other')] : [ $data->workout_id => optional($data->workout)->title ];

        $pageTitle = __('message.update_form_title',[ 'form' => __('message.class_schedule') ]);
        return view('class_schedule.form', compact('data','id','pageTitle','workout_id'));
    }

    public function update(ClassScheduleRequest $request, $id)
    {
        $class_schedule = ClassSchedule::findOrFail($id);

        $data = $request->all();
        $data['workout_title'] = $request->workout_id == 'other' ? $request->workout_title : null;
        $data['workout_id'] = $request->workout_id != 'other' ? $request->workout_id : null;
        $data['workout_type'] = $request->workout_id == 'other' ? 'other' : 'workout';

        // ClassSchedule data...
        $class_schedule->fill($data)->update();

        if(auth()->check()){
            return redirect()->route('classschedule.index')->withSuccess(__('message.update_form',['form' => __('message.class_schedule')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.class_schedule') ] ));

    }

    public function destroy($id)
    {
        $class_schedule = ClassSchedule::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.class_schedule')]);

        if($class_schedule != '') {
            $class_schedule->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.class_schedule')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
