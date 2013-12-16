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

        static public var AreaIndex:int = 0;

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

        public function GameState(restart:Boolean = false)
        {

            if (restart)
            {
                AreaIndex = 0;
            }

            setupEnemies();
            setupObstacles();

            areaClear = false;


            if (AreaIndex == 2)
            {
                player = new Player(500, 150);
            }
            else
            {
                player = new Player(400, 400);
            }

            add(player);

        }

        public function setupArea(areaIndex:int):void
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

            numberOfEnemies = 0;

            if (AreaIndex == 0)
            {
                addEnemy(200, 200);
                addEnemy(400, 150);
                addEnemy(150, 330);
            }
            else if (AreaIndex == 1)
            {
                addEnemy(160, 200);
                addEnemy(300, 150);
                addEnemy(470, 230);
                addEnemy(100, 100);
            }
            else if (AreaIndex == 2)
            {
                addEnemy(100, 450);
                addEnemy(120, 300);
                addEnemy(530, 430);
                addEnemy(150, 150);
            }
        }

        public function addEnemy(x:int, y:int):void
        {
            var enemy:Enemy = new Enemy(x, y);
            add(enemy);
            enemies.push(enemy);
            numberOfEnemies++;
        }

        public function setupObstacles():void
        {
            obstacles = new Array();

            if (AreaIndex == 0)
            {
                addObstacle(550, 50);
                addObstacle(70, 450);
                addObstacle(590, 410);
            }
            else if (AreaIndex == 1)
            {

                addObstacle(600, 50);
                addObstacle(50, 400);
                addObstacle(300, 250);
            }
            else if (AreaIndex == 2)
            {
                addObstacle(50, 50);
                addObstacle(150, 50);

                addObstacle(300, 300);
                addObstacle(300, 400);
                addObstacle(400, 400);

                addObstacle(600, 60);
            }
            addObstacle(0, 0, true);
            addObstacle(750, 0, true);
            addObstacle(0, 0, true, 1);
            addObstacle(0, 550, true, 1);

        }

        public function addObstacle(x:int, y:int, wall:Boolean = false, wallSide:int = 0):void
        {
            var obstacle:Obstacle = new Obstacle(x, y, wall, wallSide, AreaIndex);
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
                    player.loseHealth(5);
                });

                enemies[i].MoveTowards(player.getPlayerSprite(), obstacles);

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
                    FlxG.switchState(new NewSceneState());
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
