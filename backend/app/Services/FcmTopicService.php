<?php

namespace App\Services;

use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use Exception;
use Illuminate\Support\Facades\Log;

class FcmTopicService
{
    protected $messaging;

    public function __construct()
    {
        try {
            $credentialsPath = storage_path('app/firebase.json');
            
            if (!$credentialsPath || !file_exists($credentialsPath)) {
                throw new Exception('Firebase credentials file not found. Please set FIREBASE_CREDENTIALS in .env');
            }

            $factory = (new Factory)->withServiceAccount($credentialsPath);
            $this->messaging = $factory->createMessaging();
        } catch (Exception $e) {
            Log::error('FCM Service initialization failed: ' . $e->getMessage());
            throw $e;
        }
    }

    public function sendToTopic(string $topic, string $title, string $body): array
    {
            $notification = Notification::create($title, $body);
            $message  = CloudMessage::new()
    ->withNotification( $notification)
    ->toTopic($topic)
;
            $result = $this->messaging->send($message);
            return [
                'success' => true,
                'message' => 'Notification sent successfully',
                'result' => $result
            ];
    }


    public function sendToMultipleTopics(array $topics, string $title, string $body): array
    {
        $results = [];
        $successCount = 0;
        $failureCount = 0;

        foreach ($topics as $topic) {
            try {
                $result = $this->sendToTopic($topic, $title, $body);
                $results[$topic] = [
                    'success' => true,
                    'result' => $result
                ];
                $successCount++;
            } catch (Exception $e) {
                $results[$topic] = [
                    'success' => false,
                    'error' => $e->getMessage()
                ];
                $failureCount++;
            }
        }
        return [
            'success' => $failureCount === 0,
            'total' => count($topics),
            'success_count' => $successCount,
            'failure_count' => $failureCount,
            'results' => $results
        ];
    }
}
