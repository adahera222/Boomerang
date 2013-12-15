package
{
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;

    public class Enemy extends FlxGroup
    {
        private static var MAXIMUM_HEALTH:int = 3;

        /**
         * Enemy Sprites
         */
        [Embed(source="../assets/Enemy_cropped_scaled.png")] private var EnemyImage:Class;
        private var enemySprite:FlxSprite;
        private var enemySpriteTemp:FlxSprite;

        /**
         * Enemy sound
         */
        [Embed(source="../assets/Randomize18.mp3")] private var EnemySound:Class;


        // Health Bar
        private var redBarHealth:FlxSprite;
        private var greenBarHealth:FlxSprite;
        private var greenBarHealthWidth:int;

        private var position:Vector2D;

        private var currentHealth:int;

        private var timeSinceLostHealth:Number;

        public var enemyAlive:Boolean;

        private var speed:int;

        public function Enemy(x:int, y:int):void
        {
            currentHealth = MAXIMUM_HEALTH;

            enemyAlive = true;

            timeSinceLostHealth = 1;

            speed = 2;

            position = new Vector2D(0, 0);

            position.x = x;
            position.y = y;

            enemySprite = new FlxSprite(x, y);
            enemySprite.loadGraphic(EnemyImage);
            add(enemySprite);

            enemySpriteTemp = new FlxSprite(x, y);
            enemySpriteTemp.loadGraphic(EnemyImage);
            enemySpriteTemp.visible = false;
            add(enemySpriteTemp);

            setupHealthBar();
            setHealthBarPosition(position.x, position.y);

        }


        public function setupHealthBar():void
        {
            redBarHealth = this.recycle(FlxSprite) as FlxSprite;
            redBarHealth.x = 600;
            redBarHealth.y = 10;
            redBarHealth.makeGraphic(100, 10, 0xff000000);
            add(redBarHealth);

            greenBarHealth = this.recycle(FlxSprite) as FlxSprite;
            greenBarHealth.x = 600;
            greenBarHealth.y = 10;
            greenBarHealth.makeGraphic((currentHealth/MAXIMUM_HEALTH) * 100, 10, 0xfffd4444);
            greenBarHealthWidth = currentHealth;
            add(greenBarHealth);
        }

        public function setHealthBarPosition(x:int, y: int):void
        {
            redBarHealth.x = x - 20;
            redBarHealth.y = y + 50;
            greenBarHealth.x = x - 20;
            greenBarHealth.y = y + 50;
        }

        public function loseHealth(loseValue:int = 1):void
        {

            if (timeSinceLostHealth > 1)
            {
                if (currentHealth > 1)
                {
                    currentHealth -= loseValue;
                    timeSinceLostHealth = 0;

                    if (greenBarHealthWidth != currentHealth)
                    {
                        greenBarHealth.makeGraphic((currentHealth/MAXIMUM_HEALTH) * 100, 10, 0xfffd4444);
                        greenBarHealthWidth = currentHealth;
                    }
                }
                else
                {
                    if (enemyAlive)
                    {
                        enemyAlive = false;
                    }
                }
            }

        }

        public function MoveTowards(player:FlxSprite, obstacles:Array):void
        {
            var dirX:Number = player.x - position.x;
            var dirY:Number = player.y - position.y;

            var hypotenuse:Number = Math.sqrt(Math.pow(dirX, 2) + Math.pow(dirY, 2));
            dirX /= hypotenuse;
            dirY /= hypotenuse;

            var newX:Number = position.x + (dirX * speed);
            var newY:Number = position.y + (dirY * speed);

            enemySpriteTemp.x = newX;
            enemySpriteTemp.y = newY;

            var diffX:Number = newX - player.x;
            var diffY:Number = newY - player.y;

            var distanceFromTarget:Number = Math.sqrt(Math.pow(diffX, 2) + Math.pow(diffY, 2));

            if (distanceFromTarget < 10)
            {
              //  FlxG.play(EnemySound);
            }

            var move:Boolean = true;

            FlxG.overlap(enemySpriteTemp, player, function():void
            {
                 move = false;
            });

            for(var i = 0; i < obstacles.length; i++)
            {
                FlxG.overlap(enemySpriteTemp, obstacles[i], function():void
                {
                    move = false;
                })
            }

            if (move)
            {
                position.x = enemySpriteTemp.x;
                position.y = enemySpriteTemp.y;

                setHealthBarPosition(position.x, position.y);

                enemySprite.x = position.x;
                enemySprite.y = position.y;
            }
            else
            {
                position.x = enemySprite.x;
                position.y = enemySprite.y;
            }
        }

        override public function update():void
        {
            timeSinceLostHealth += FlxG.elapsed;
        }
    }
}
