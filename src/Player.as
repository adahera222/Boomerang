package
{
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;

    public class Player extends FlxGroup
    {

        /**
         * Sprites
         */

        // Player Sprite
        [Embed('../assets/Player_cropped_scaled.png')] private var SpriteImage:Class;
        private var playerSprite:FlxSprite;

        // Target Sprite
        private var targetSprite:FlxSprite;

        /**
         * The Boomerang
         */
        private var boomerang:Boomerang;
        private var boomerangHeld:Boolean;

        /**
         * Player variables
         */
        // Player Position
        private var position:Vector2D;
        // Target
        private var targetPosition:Vector2D;
        // Movement
        private var walkSpeed:int;

        public function Player(x:int, y:int):void
        {
            position = new Vector2D(0, 0);
            targetPosition = new Vector2D(0, 0);
            walkSpeed = 4;

            boomerang = new Boomerang(0, 0);
            add(boomerang);
            boomerangHeld = true;

            setupSprites();
            setPlayerPosition(x, y);

        }

        public function setupSprites():void
        {
            playerSprite = new FlxSprite(0, 0);
            playerSprite.antialiasing = true;
            playerSprite.loadGraphic(SpriteImage);
            add(playerSprite);

            targetSprite = new FlxSprite(-50, -50);
            targetSprite.makeGraphic(5, 5, 0xffff1111);
            targetSprite.visible = true;
            add(targetSprite);
        }

        public function setPlayerPosition(x:int, y:int):void
        {
            position.x = x;
            position.y = y;

            playerSprite.x = position.x;
            playerSprite.y = position.y;

            if (boomerangHeld)
            {
                boomerang.setBoomerangPosition(position.x, position.y - 20);
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
            setPlayerPosition(position.x, position.y - walkSpeed);
        }

        public function moveDown():void
        {
            setPlayerPosition(position.x, position.y + walkSpeed);
        }

        public function moveLeft():void
        {
            setPlayerPosition(position.x - walkSpeed, position.y);
        }

        public function moveRight():void
        {
            setPlayerPosition(position.x + walkSpeed, position.y);
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
                targetSprite.visible = true;
                boomerangHeld = false;
                boomerang.throwBoomerang();
            }

        }

        public function CollisionCheck():void
        {
            if (boomerang.returning)
            {
                FlxG.overlap(playerSprite, boomerang.boomerangSprite, function():void {
                    boomerang.caughtBoomerang();
                    boomerangHeld = true;
                    setPlayerPosition(position.x, position.y);
                });
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
