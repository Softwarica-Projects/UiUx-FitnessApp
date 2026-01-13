<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PushNotification;
use App\DataTables\PushNotificationDataTable;
use App\Models\User;
use App\Notifications\CommonNotification;
use App\Notifications\DatabaseNotification;
use App\Models\Notification;
use App\Helpers\AuthHelper;
use App\Services\FcmTopicService;
use Illuminate\Support\Facades\Log;

class PushNotificationController extends Controller
{
    public function index(PushNotificationDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title', ['form' => __('message.pushnotification')]);
        $auth_user = AuthHelper::authSession();
        $assets = ['data-table'];

        $headerAction = '<a href="' . route('pushnotification.create') . '" class="btn btn-sm btn-primary" role="button">' . __('message.add_form_title', ['form' => __('message.pushnotification')]) . '</a>';

        return $dataTable->render('global.datatable', compact('pageTitle', 'auth_user', 'assets', 'headerAction'));
    }

    public function create()
    {
        $pageTitle = __('message.add_form_title', ['form' => __('message.pushnotification')]);
        $relation = [
            'user' => User::where('user_type', 'user')->where('status', 'active')->get()->pluck('display_name', 'id'),
        ];

        return view('push_notification.form', compact('pageTitle') + $relation);
    }

    public function store(Request $request)
    {

        $notify_type = $request->notify_type ?? null;
        $pushnotification = PushNotification::create($request->all());

        storeMediaFile($pushnotification, $request->notification_image, 'notification_image');

        $notification_data = [
            'id' => $pushnotification->id,
            'push_notification_id' => $pushnotification->id,
            'type' => 'push_notification',
            'subject' => $pushnotification->title,
            'message' => $pushnotification->message,
        ];
        if (getMediaFileExit($pushnotification, 'notification_image')) {
            $notification_data['image'] = getSingleMedia($pushnotification, 'notification_image');
        } else {
            $notification_data['image'] = null;
        }

        User::whereIn('id', $request->user)->chunk(20, function ($userdata) use ($notification_data) {
            foreach ($userdata as $user) {
                $user->notify(new CommonNotification($notification_data['type'], $notification_data));
                $user->notify(new DatabaseNotification($notification_data));
            }
        });
        try {
            $fcmService = new FcmTopicService();
            $fcmService->sendToMultipleTopics(
                $request->user,
                $pushnotification->title,
                $pushnotification->message
            );
        } catch (\Exception $e) {
            
        }

        return redirect()->route('pushnotification.index')->withSuccess(__('message.' . ($notify_type != 'resend' ? 'pushnotification_send_success' : 'pushnotification_resend_success')));
    }

    public function edit($id)
    {

        $data = PushNotification::findOrFail($id);
        $pageTitle = __('message.resend_pushnotification');
        $relation = [
            'user' => User::where('user_type', 'user')->where('status', 'active')->get()->pluck('display_name', 'id'),
        ];

        return view('push_notification.form', compact('data', 'id', 'pageTitle') + $relation);
    }

    public function destroy($id)
    {
        $pushnotification = PushNotification::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.pushnotification')]);

        if ($pushnotification != '') {
            // $search = "push_notification_id".'":'.$id;
            // Notification::where('data','like',"%{$search}%")->delete();
            Notification::whereJsonContains('data->push_notification_id', $id);
            $pushnotification->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.pushnotification')]);
        }

        if (request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message]);
        }

        return redirect()->back()->with($status, $message);
    }
}
