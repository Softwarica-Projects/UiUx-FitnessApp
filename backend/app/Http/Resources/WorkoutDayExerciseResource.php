<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Http\Resources\ExerciseResource;

class WorkoutDayExerciseResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id'                => $this->id,
            'workout_id'        => $this->workout_id,
            'workout_day_id'    => $this->workout_day_id,
            'exercise_id'       => $this->exercise_id,
            'exercise_image'    => getSingleMedia($this->exercise, 'exercise_image',null),
            'exercise_title'    => optional($this->exercise)->title,
            'exercise'          => new ExerciseResource($this->exercise), 
            'sequence'          => $this->sequence,
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at,
        ];
    }
}
