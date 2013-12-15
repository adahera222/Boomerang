package
{
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class GameState extends FlxState
    {

        [Embed('../assets/Explosion17.mp3')] private var EnemyKilledSound:Class;

        private var player:Player;

        private var enemies:Array;
        private var obstacles:Array;

        private var numberOfEnemies:int;
        private var areaClear:Boolean;
        private var areaClearTimer:Number;

        static private var AreaIndex:int = 0;

        static public function SetNextAreaIndex():void
        {
            AreaIndex++;

            if (AreaIndex == 3)
            {
                AreaIndex = 0;
            }
        }

        override public function create():void
        {
            setupArea(AreaIndex);
            SetNextAreaIndex();
        }

        public function GameState()
        {

            setupEnemies();
            setupObstacles();

            areaClear = false;
            player = new Player(400, 400);
            add(player);

        }

        public function setupArea(areaIndex:int)
        {
            switch (areaIndex)
            {
                case 0:
                    FlxG.bgColor = 0xffbdb284;
                    break;
                case 1:
                    FlxG.bgColor = 0xffffffff;
                    break;
                case 2:
                    FlxG.bgColor = 0xff548f3d;
                    break;
            }
        }

        public function setupEnemies():void
        {
            enemies = new Array();

            var enemy:Enemy;

            enemy = new Enemy(200, 200);
            add(enemy);
            enemies.push(enemy);

            enemy = new Enemy(400, 150);
            add(enemy);
            enemies.push(enemy);

            numberOfEnemies = 2;
        }

        public function setupObstacles():void
        {
            obstacles = new Array();

            //wall
            addObstacle(0, 0, true);
            addObstacle(750, 0, true);
            addObstacle(0, 0, true, 1);
            addObstacle(0, 550, true, 1);

            addObstacle(500, 50);
            addObstacle(150, 400);
            addObstacle(300, 250);
        }

        public function addObstacle(x:int, y:int, wall:Boolean = false, wallSide:int = 0)
        {
            var obstacle:Obstacle = new Obstacle(x, y, wall, wallSide);
            add(obstacle);
            obstacles.push(obstacle);
        }

        public function CollisionChecks():void
        {
            if (!player.boomerangHeld && !player.boomerangOnFloor)
            {
                for(var i:int = 0; i < enemies.length; i++)
                {
                    FlxG.overlap(player.getBoomerangSprite(), enemies[i], function():void
                    {
                        enemies[i].loseHealth(1);

                        if (!enemies[i].enemyAlive)
                        {
                            enemies[i].kill();
                            FlxG.play(EnemyKilledSound);
                            numberOfEnemies--;
                        }

                    });

                }

                for(var i:int = 0; i < obstacles.length; i++)
                {
                    FlxG.overlap(player.getBoomerangSprite(), obstacles[i], function():void
                    {
                        player.boomerangStopped();
                    })
                }
            }

            for(var i:int = 0; i < enemies.length; i++)
            {
                FlxG.overlap(player.getPlayerSprite(), enemies[i], function():void
                {
                    player.loseHealth(20);
                });

                //enemies[i].MoveTowards(player.getPlayerSprite(), obstacles);

            }

        }

        public function WinCheck():void
        {
            if (numberOfEnemies <= 0)
            {
                if (!areaClear)
                {
                    var text:FlxText = new FlxText(50, 50, 200, "Area Clear");

                    if (AreaIndex == 2)
                    {
                        text.setFormat(null, 20, 0xff000000);
                    }
                    else
                    {
                        text.setFormat(null, 20, 0xffffffff);
                    }

                    add(text);
                    areaClear = true;
                    areaClearTimer = 0;
                }

            }

            if (areaClear)
            {
                areaClearTimer += FlxG.elapsed;

                if (areaClearTimer > 2)
                {
                    FlxG.switchState(new GameState());
                }
            }
        }

        override public function update():void
        {
            CollisionChecks();
            WinCheck();

            super.update();
        }
    }
}
