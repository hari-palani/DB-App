<?php
$con=mysqli_connect("localhost","root","","demodb");

if(isset($_POST["tid"]))
{
    $tid = $_POST["tid"];
}
else return;

$query="DELETE FROM `courier` WHERE `tid` = '$tid'";

$exe = mysqli_query($con,$query);
$arr = [];

if($exe)
{
    $arr["success"] = "true";
}
else
{
    $arr["success"] = "false";
}
print(json_encode($arr));

?>