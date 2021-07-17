<?php

require 'C:/xampp/htdocs/proyecto/vendor/autoload.php';

$uri="mongodb://localhost:27017/?readPreference=primary&appname=MongoDB%20Compass&ssl=false";

$client=new MongoDB\Client($uri);

if($client){
    echo "<script>console.log('Conexion satisfactoria')</script>";
  }else{
    echo "<script>console.log('Error de conexion')</script>";
}
?>