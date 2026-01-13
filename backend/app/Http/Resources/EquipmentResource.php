<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class EquipmentResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id'            => $this->id,
            'title'         => $this->title,
            'status'        => $this->status,
            'equipment_image'   => getSingleMedia($this, 'equipment_image',null),
            'created_at'    => $this->created_at,
            'updated_at'    => $this->updated_at,
        ];
    }
}