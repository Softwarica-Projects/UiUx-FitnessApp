<?php

return [
    'namespace' => [
        'base' => 'DataTables',
        'model' => '',
    ],
    'pdf_generator' => 'snappy',
    'snappy' => [
        'options' => [
            'no-outline' => true,
            'margin-left' => '0',
            'margin-right' => '0',
            'margin-top' => '10mm',
            'margin-bottom' => '10mm',
        ],
        'orientation' => 'landscape',
    ],
    'parameters' => [
        'dom' => 'Bfrtip',
        'order' => [[0, 'desc']],
        'buttons' => [
            'create',
            'export',
            'print',
            'reset',
            'reload',
        ],
    ],

    'generator' => [
        'columns' => 'id,add your columns,created_at,updated_at',
        'buttons' => 'create,export,print,reset,reload',
        'dom' => 'Bfrtip',
    ],
];
