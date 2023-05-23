<?php

namespace App\Console\Commands;

use App\Models\Driver;
use Illuminate\Console\Command;

class checkUserOnline extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'user:online';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Check User online or not by Every Minute';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {

    }
}
