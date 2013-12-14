package
{
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class GameState extends FlxState
    {
        private var player:Player;

        private var enemies:Array;
        private var obstacles:Array;

        private var numberOfEnemies:int;

        public function GameState()
        {
            player = new Player(400, 400);
            add(player);

            setupEnemies();
            setupObstacles();
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

            var obstacle:Obstacle;

            obstacle = new Obstacle(500, 50);
            add(obstacle);
            obstacles.push(obstacle);

            obstacle = new Obstacle(150, 400);
            add(obstacle);
            obstacles.push(obstacle);

            obstacle = new Obstacle(300, 250);
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
                        enemies[i].kill();
                        numberOfEnemies--;
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
                    player.loseHealth();
                });
            }

        }

        public function WinCheck():void
        {
            if (numberOfEnemies <= 0)
            {
                var text:FlxText = new FlxText(50, 50, 200, "Area Clear");
                text.setFormat(null, 20);
                add(text);
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
