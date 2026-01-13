<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Role;

class RoleTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        $roles = [
            [
                'name' => 'admin',
                'title' => 'Admin',
                'status' => 1
            ],
            [
                'name' => 'user',
                'title' => 'User',
                'status' => 1
            ]
        ];

        foreach ($roles as $key => $value) {
            $role = Role::create($value);
        }
    }
}
