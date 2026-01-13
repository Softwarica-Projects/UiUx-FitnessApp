<?php
return [
    'IMAGE_EXTENTIONS' => ['png', 'jpg', 'jpeg', 'gif'],
    'PER_PAGE_LIMIT' => 10,
    'MAIL_SETTING' => [
        'MAIL_MAILER' => env('MAIL_MAILER'),
        'MAIL_HOST' => env('MAIL_HOST'),
        'MAIL_PORT' => env('MAIL_PORT'),
        'MAIL_USERNAME' => env('MAIL_USERNAME'),
        'MAIL_PASSWORD' => env('MAIL_PASSWORD'),
        'MAIL_ENCRYPTION' => env('MAIL_ENCRYPTION'),
        'MAIL_FROM_ADDRESS' => env('MAIL_FROM_ADDRESS'),
        'MAIL_FROM_NAME' => env('MAIL_FROM_NAME'),
    ],
    'MAIL_PLACEHOLDER' => [
        'MAIL_MAILER' => 'smtp',
        'MAIL_HOST' => 'smtp.gmail.com',
        'MAIL_PORT' => '587',
        'MAIL_ENCRYPTION' => 'tls',
        'MAIL_USERNAME' => 'youremail@gmail.com',
        'MAIL_PASSWORD' => 'Password',
        'MAIL_FROM_ADDRESS' => 'youremail@gmail.com',
        'MAIL_FROM_NAME' => 'From Name',
    ],
];
