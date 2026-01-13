<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

class DatabaseNotification extends Notification
{
    use Queueable;
    public $data;
    public function __construct($data)
    {
        $this->data = $data;
    }
    public function via($notifiable)
    {
        return ['database'];
    }

    public function toMail($notifiable)
    {
        
    }
    public function toArray($notifiable)
    {
        return $this->data;
    }
}
