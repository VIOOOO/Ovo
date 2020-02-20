<?php

header("Access-Control-Allow-Origin: *");

$str='';
$str.="Upload".$_FILES["file"]["name"]."\r\n";
$str.="Type".$_FILES["file"]["type"]."\r\n";


move_uploaded_file($_FILES["file"]['tmp_name'], 'upload_test/'.$_FILES["file"]["name"]);

$str.= "Stored in:"."upload_test/".$_FILES["file"]["name"]."\r\n";




$name=$_POST['username'];
$age=$_POST['age'];
$height=$_POST['height'];

$str.='姓名'.$name."\r\n";
$str.='年龄'.$age."\r\n";
$str.='身高'.$height."\r\n";
file_put_contents('upload_test/upload.txt', $str);

echo $str;




?>
