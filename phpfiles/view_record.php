<?php

$con=mysqli_connect("localhost","root","","demodb");

$query = "SELECT `tid`, `cnum`, `cname`, `date` FROM `courier`";
$exe = mysqli_query($con,$query);
$arr = [];
while($row=mysqli_fetch_array($exe)){
    $arr[]=$row;
}

print(json_encode($arr));
?>