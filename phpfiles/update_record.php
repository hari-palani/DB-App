<?php
$con=mysqli_connect("localhost","root","","demodb");
if(isset($_POST["tid"]))
{
    $tid = $_POST["tid"];
}
else return;

if(isset($_POST["cnum"]))
{
    $cnum = $_POST["cnum"];
}
else return;

if(isset($_POST["cname"]))
{
    $cname = $_POST["cname"];
}
else return;

$query="UPDATE `courier` SET `cnum`='$cnum',`cname`='$cname' WHERE `tid`='$tid'";

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