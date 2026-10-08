<body>
<?php include 'header.php';?>

<div class="container-fluid">
        <div class="row custompad">
            <div class="col-lg-12 px-0">


            <?php

$row = 1;
if (($file = fopen("resources_aa30e45e-04a7-4657-96e2-b6dd7ab6718c_ancient_trees.csv", "r")) !== FALSE) {
   
    echo '<table class="table" id="myTable">';
   
    while (($data = fgetcsv($file,100000,",")) !== FALSE) {
        $num = count($data);
        if ($row == 1) {
            echo '<thead><tr>';
        }else{
            echo '<tr>';
        }
       
        for ($c=0; $c < $num; $c++) {
            if(empty($data[$c])) {
               $value = "&nbsp;";
            }else{
               $value = $data[$c];
            }
            if ($row == 1) {
                echo '<th>'.$value.'</th>';
            }else{
                echo '<td>'.$value.'</td>';
            }
        }
       
        if ($row == 1) {
            echo '</tr></thead><tbody>';
        }else{
            echo '</tr>';
        }
        $row++;
    }
   
    echo '</tbody></table>';
    fclose($file);
}
?>

        
            </div>
            
        </div>
    </div>
    <!-- Main News Slider End -->

<script>
$('#myTable').DataTable();
$(document).ready(function(){
    $('.navbar-nav a:eq(2)').removeClass('active')
    $('.navbar-nav a:eq(3)').addClass('active')

});
</script>

    <?php include 'footer.php';?>
    
</body>
</html>