package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;

    public class Obstacle extends FlxGroup
    {

        /***
         * Obstacle sprites
         */
        [Embed("../assets/Obstacle_Desert_cropped_scaled.png")] private var ObstacleDesertImage:Class;
        [Embed("../assets/Obstacle_Snow_cropped_scaled.png")] private var ObstacleSnowImage:Class;
        [Embed("../assets/Obstacle_Forest_cropped_scaled.png")] private var ObstacleForestImage:Class;
        private var obstacleSprite:FlxSprite;

        [Embed("../assets/Wall_cropped_scaled.png")] private var WallImage_Desert_0:Class;
        [Embed("../assets/Wall_1_cropped_scaled.png")] private var WallImage_Desert_1:Class;

        [Embed("../assets/Wall_Snow_cropped_scaled.png")] private var WallImage_Snow_0:Class;
        [Embed("../assets/Wall_1_Snow_cropped_scaled.png")] private var WallImage_Snow_1:Class;

        [Embed("../assets/Wall_Forest_cropped_scaled.png")] private var WallImage_Forest_0:Class;
        [Embed("../assets/Wall_1_Forest_cropped_scaled.png")] private var WallImage_Forest_1:Class;

        public function Obstacle(x:int, y:int, wall:Boolean = false, wallSide:int = 0, type:int = 0):void
        {
            obstacleSprite = new FlxSprite(x, y);
            if (wall)
            {
                if (wallSide == 0)
                {
                    if (type == 0)
                    {
                        obstacleSprite.loadGraphic(WallImage_Desert_0);
                    }
                    else if (type == 1)
                    {
                        obstacleSprite.loadGraphic(WallImage_Snow_0);
                    }
                    else if (type == 2)
                    {
                        obstacleSprite.loadGraphic(WallImage_Forest_0);
                    }
                }
                else
                {
                    if (type == 0)
                    {
                        obstacleSprite.loadGraphic(WallImage_Desert_1);
                    }
                    else if (type == 1)
                    {
                        obstacleSprite.loadGraphic(WallImage_Snow_1);
                    }
                    else if (type == 2)
                    {
                        obstacleSprite.loadGraphic(WallImage_Forest_1);
                    }
                }

            }
            else
            {
                if (type == 0)
                {
                    obstacleSprite.loadGraphic(ObstacleDesertImage);
                }
                else if (type == 1)
                {
                    obstacleSprite.loadGraphic(ObstacleSnowImage);
                }
                else if (type == 2)
                {
                    obstacleSprite.loadGraphic(ObstacleForestImage);
                }
            }

            add(obstacleSprite);
        }
    }
}
