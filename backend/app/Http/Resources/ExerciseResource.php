<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\BodyPart;

class ExerciseResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id'            => $this->id,
            'title'         => $this->title,
            'status'        => $this->status,
            'exercise_image'=> getSingleMedia($this, 'exercise_image', null),
            'duration'      => $this->duration,
            'sets'          => $this->sets,
            'based'         => $this->based,
            'type'          => $this->type,
            'created_at'    => $this->created_at,
            'updated_at'    => $this->updated_at,
        ];
    }
}