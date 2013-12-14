package
{
    import org.flixel.FlxButton;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxText;

    public class Player extends FlxGroup
    {
        private static var MAXIMUM_HEALTH:int = 100;

        /**
         * Sprites
         */

        // Player Sprite
        [Embed('../assets/Player_cropped_scaled.png')] private var SpriteImage:Class;
        private var playerSprite:FlxSprite;
        private var playerSpriteTemp:FlxSprite;

        // Target Sprite
        private var targetSprite:FlxSprite;

        // Health Bar
        private var redBarHealth:FlxSprite;
        private var greenBarHealth:FlxSprite;

        /**
         * The Boomerang
         */
        public var boomerang:Boomerang;
        public var boomerangHeld:Boolean;
        public var boomerangOnFloor:Boolean;

        /**
         * Player variables
         */
        // Player Position
        private var position:Vector2D;
        // Target
        private var targetPosition:Vector2D;
        // Movement
        private var walkSpeed:int;
        // Player Health
        private var currentHealth:int;

        public function Player(x:int, y:int):void
        {
            currentHealth = MAXIMUM_HEALTH;

            position = new Vector2D(0, 0);
            targetPosition = new Vector2D(0, 0);
            walkSpeed = 4;

            boomerang = new Boomerang(0, 0);
            add(boomerang);
            boomerangHeld = true;

            setupSprites();
            setupHealthBar();
            setPlayerPosition(x, y);
        }

        public function setupSprites():void
        {
            playerSprite = new FlxSprite(0, 0);
            playerSprite.antialiasing = true;
            playerSprite.loadGraphic(SpriteImage);
            add(playerSprite);

            playerSpriteTemp = new FlxSprite(0, 0);
            playerSpriteTemp.antialiasing = true;
            playerSpriteTemp.loadGraphic(SpriteImage);
            playerSpriteTemp.visible = false;
            add(playerSpriteTemp);

            targetSprite = new FlxSprite(-50, -50);
            targetSprite.makeGraphic(5, 5, 0xffff1111);
            targetSprite.visible = true;
            add(targetSprite);
        }

        public function setupHealthBar():void
        {
            redBarHealth = new FlxSprite(600, 10);
            redBarHealth.makeGraphic(MAXIMUM_HEALTH, 10, 0xfffd4444);
            add(redBarHealth);

            greenBarHealth = new FlxSprite(600, 10);
            greenBarHealth.makeGraphic(currentHealth, 10, 0xff16b021);
            add(greenBarHealth);
        }

        public function setPlayerPosition(x:int, y:int, useCollision:Boolean = false):void
        {

            position.x = x;
            position.y = y;

            playerSpriteTemp.x = position.x;
            playerSpriteTemp.y = position.y;

            var move:Boolean = true;

            if (useCollision)
            {
                var allMembers:Array = FlxG.state.members;

                for(var i:int = 0; i < allMembers.length; i++)
                {
                    if (allMembers[i] == "Obstacle" || allMembers[i] == "Enemy")
                    {
                        FlxG.overlap(playerSpriteTemp, allMembers[i], function():void
                        {
                            move = false;

                            if (allMembers[i] == "Enemy")
                            {
                                loseHealth();
                            }
                        });
                    }
                }
            }
            else
            {
                move = true;
            }


            if (move)
            {
                playerSprite.x = position.x;
                playerSprite.y = position.y;

                if (boomerangHeld)
                {
                    boomerang.setBoomerangPosition(position.x, position.y - 20);
                }
            }
            else
            {
                position.x = playerSprite.x;
                position.y = playerSprite.y;
            }

        }

        public function setTargetPosition(x:int, y:int):void
        {
            targetPosition.x = x;
            targetPosition.y = y;

            targetSprite.x = targetPosition.x;
            targetSprite.y = targetPosition.y;
        }

        public function setPlayerAngle(angle:Number):void
        {
            playerSprite.angle = angle + 90;

            if (boomerangHeld)
            {
                boomerang.setBoomerangAngle(angle + 90);
            }
        }

        public function setRotationToTarget():void
        {
            var dx:Number = targetPosition.x - playerSprite.x;
            var dy:Number = targetPosition.y - playerSprite.y;
            var angle:Number = Math.atan2(dy, dx) * 180 / Math.PI;

            setPlayerAngle(angle);
        }

        public function moveUp():void
        {
            setPlayerPosition(position.x, position.y - walkSpeed, true);
        }

        public function moveDown():void
        {
            setPlayerPosition(position.x, position.y + walkSpeed, true);
        }

        public function moveLeft():void
        {
            setPlayerPosition(position.x - walkSpeed, position.y, true);
        }

        public function moveRight():void
        {
            setPlayerPosition(position.x + walkSpeed, position.y, true);
        }

        public function KeyboardControls():void
        {
            if (FlxG.keys.W || FlxG.keys.UP)
            {
                moveUp();
            }

            if (FlxG.keys.A || FlxG.keys.LEFT)
            {
                moveLeft();
            }

            if (FlxG.keys.S || FlxG.keys.DOWN)
            {
                moveDown();
            }

            if (FlxG.keys.D || FlxG.keys.RIGHT)
            {
                moveRight();
            }
        }

        public function MouseControls():void
        {
            setTargetPosition(FlxG.mouse.x, FlxG.mouse.y);
            setRotationToTarget();

            if (FlxG.mouse.pressed())
            {
                boomerang.setAndShowTargets(targetPosition.x, targetPosition.y);
                targetSprite.visible = false;
            }

            if (FlxG.mouse.justReleased())
            {
                if (boomerangHeld)
                {
                    targetSprite.visible = true;
                    boomerangHeld = false;
                    boomerangOnFloor = false;
                    boomerang.throwBoomerang();
                }
            }
        }

        public function CollisionCheck():void
        {
            if (boomerang.returning || boomerangOnFloor)
            {
                FlxG.overlap(playerSprite, boomerang.boomerangSprite, function():void {
                    boomerang.caughtBoomerang();
                    boomerangHeld = true;
                    setPlayerPosition(position.x, position.y);
                });
            }
        }

        public function loseHealth():void
        {
            if (currentHealth > 1)
            {
                currentHealth--;
                greenBarHealth.makeGraphic(currentHealth, 10, 0xff16b021);
            }
            else
            {
                var text:FlxText = new FlxText(50, 50, 200, "You are dead");
                text.setFormat(null, 20);
                add(text);
            }
        }

        public function getBoomerangSprite():FlxSprite
        {
            return boomerang.boomerangSprite;
        }

        public function getPlayerSprite():FlxSprite
        {
            return playerSprite;
        }

        public function boomerangStopped():void
        {
            if (!boomerangHeld && !boomerangOnFloor)
            {
                boomerang.hitObstacle();
                boomerangOnFloor = true;
            }
        }

        override public function update():void
        {
            KeyboardControls();
            MouseControls();
            CollisionCheck();
            super.update();
        }
    }
}
