package
{
    public class Vector2D
    {

        public var x:int;
        public var y:int;

        public function Vector2D(x:int, y:int)
        {
            x = x;
            y = y;
        }

        public function getLength():Number
        {
            return Math.sqrt(Math.pow(x, 2) + Math.pow(x, 2));
        }

        static public function Distance(v1:Vector2D, v2:Vector2D):Number
        {
            var diff:Vector2D = new Vector2D(0, 0);
            diff.x = v1.x - v2.x;
            diff.y = v2.x - v2.y;

            return diff.getLength();
        }
    }
}
