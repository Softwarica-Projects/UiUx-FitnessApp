<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class CommonNotification extends Notification
{
    use Queueable;
    public $type, $data, $subject, $notification_message;
    public function __construct($type, $data)
    {
        $this->type = $type;
        $this->data = $data;
        $this->subject = str_replace("_"," ",ucfirst($this->data['subject']));
        $this->notification_message = $this->data['message'] != '' ? $this->data['message'] : __('message.default_notification_body');
    }

    public function via($notifiable)
    {
        $notifications = []; 
        return $notifications;
    }

    public function toMail($notifiable)
    {
        return (new MailMessage)
                    ->line('Notification Introductory Line')
                    ->action('Action', url('/'))
                    ->line('Thank you.');
    }
    public function toArray($notifiable)
    {
        return [];
    }
}
