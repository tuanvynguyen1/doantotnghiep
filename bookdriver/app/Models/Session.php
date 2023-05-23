<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Session extends Model
{
    use HasFactory;
    protected $fillable = [
        'device_name', 'tokenID'
    ];

    public function User(): BelongsTo
    {
        return $this->belongsTo(User::class, 'userID', 'id');
    }
}
