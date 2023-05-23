<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AddressBook extends Model
{
    use HasFactory;
    protected $fillable = [
        'userInfoID', 'name', 'address', 'lat', 'long'
    ];

    public function userInfo(): BelongsTo
    {
        return $this->belongsTo(UserInfo::class, 'userInfoID', 'id');
    }
}
