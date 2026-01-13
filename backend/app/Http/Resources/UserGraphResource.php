<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class UserGraphResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id'            => $this->id,
            'value'         => $this->value,
            'type'          => $this->type,
            'date'          => $this->date,
            'unit'          => $this->unit,
            'created_at'    => $this->created_at,
            'updated_at'    => $this->updated_at,
        ];
    }
}
