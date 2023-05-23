<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DriverLicense extends Model
{
    use HasFactory;
    protected $fillable = [
        'driverID', 'rank', 'front', 'back', 'status', 'reason'
    ];
    public function Driver(): BelongsTo{
        return $this->belongsTo(Driver::class,'driverID', 'id');
    }
}
