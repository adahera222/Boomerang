package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;

    public class Boomerang extends FlxGroup
    {
        /**
         * Boomerang Sprites
         */
        [Embed('../assets/Boomerang_cropped_scaled.png')] private var BoomerangImage:Class;
        public var boomerangSprite:FlxSprite;

        private var targetSprite:FlxSprite;
        private var startSprite:FlxSprite;

        private var position:Vector2D;
        private var targetPosition:Vector2D;
        private var startPosition:Vector2D;

        private var speed:Number;

        private var isThrown:Boolean;
        public var returning:Boolean;

        public function Boomerang(x:int, y:int):void
        {

            boomerangSprite = new FlxSprite(0, 0);
            boomerangSprite.antialiasing = true;
            boomerangSprite.loadGraphic(BoomerangImage);
            add(boomerangSprite);

            position = new Vector2D(0, 0);
            setBoomerangPosition(x, y);

            targetPosition = new Vector2D(0, 0);
            startPosition = new Vector2D(0, 0);

            targetSprite = new FlxSprite(0, 0);
            targetSprite.makeGraphic(10, 10, 0xffff1111);
            targetSprite.visible = false;
            add(targetSprite);

            startSprite = new FlxSprite(0, 0);
            startSprite.makeGraphic(10, 10, 0xffff1111);
            startSprite.visible = false;
            add(startSprite);

            speed = 8;

            isThrown = false;
            returning = false;
        }

        public function setBoomerangPosition(x:int, y:int):void
        {
            position.x = x;
            position.y = y;

            boomerangSprite.x = position.x;
            boomerangSprite.y = position.y;
        }

        public function setBoomerangAngle(angle:Number):void
        {
            boomerangSprite.angle = angle;
        }

        public function setAndShowTargets(x:int, y:int):void
        {
            if (!isThrown)
            {
                targetPosition.x = x;
                targetPosition.y = y;

                targetSprite.x = targetPosition.x;
                targetSprite.y = targetPosition.y;

                startPosition.x = boomerangSprite.x;
                startPosition.y = boomerangSprite.y;

                startSprite.x = startPosition.x;
                startSprite.y = startPosition.y;

          //      targetSprite.visible = true;
          //      startSprite.visible = true;
                returning = false;
            }
        }

        public function throwBoomerang():void
        {
        //    targetSprite.visible = false;
         //   startSprite.visible = false;
            isThrown = true;
        }

        public function caughtBoomerang():void
        {
            isThrown = false;
        //    targetSprite.visible = false;
        //    startSprite.visible = false;
        }

        public function moveToTarget():void
        {
            var theTarget:Vector2D;

            if (returning)
            {
                theTarget = startPosition;
            }
            else
            {
                theTarget = targetPosition;
            }


            var dirX:Number = theTarget.x - position.x;
            var dirY:Number = theTarget.y - position.y;

            var hyp = Math.sqrt(Math.pow(dirX, 2) + Math.pow(dirY, 2));
            dirX /= hyp;
            dirY /= hyp;

            var newX:Number = position.x + (dirX * speed);
            var newY:Number = position.y + (dirY * speed);

            var newPos:Vector2D = new Vector2D(newX, newY);

            var diffX = newX - theTarget.x;
            var diffY = newY - theTarget.y;

            var dist = Math.sqrt(Math.pow(diffX, 2) + Math.pow(diffY, 2));

            if (dist > 5)
            {
                setBoomerangPosition(newX, newY);
            }
            else
            {
                returning = true;
            }
        }

        public function spin():void
        {
            boomerangSprite.angle += speed;
        }

        override public function update():void
        {
            if (isThrown)
            {
                moveToTarget();
                spin();
            }

            super.update();
        }
    }
}
