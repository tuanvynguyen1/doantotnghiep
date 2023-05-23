<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class UserInfo extends Model
{
    use HasFactory;
    protected $fillable = [
        'name', 'email', 'avatar', 'phone','address', 'is_active'
    ];

    public function User(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
    public function booking(): HasMany
    {
        return $this->hasMany(booking::class, 'user_infoID', 'id');
    }
    public function AddressBook(): HasMany {
        return $this->hasMany(AddressBook::class, 'userInfoID', 'id');
    }
}
