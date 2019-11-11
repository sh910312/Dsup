<!-- Script For Global Variable   -->
<script>

</script>

<!-- Script For Menu Change  -->
<script>

</script>

<!-- Script For get Data  -->
<script>

</script>

<!-- Script For Google Chart Draw  -->
<script type="text/javascript">
google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(drawChart);
function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ["Element", "Density", { role: "style" } ],
    ["Copper", 8.94, "#b87333"],
    ["Silver", 10.49, "silver"],
    ["Gold", 19.30, "gold"],
    ["Platinum", 21.45, "color: #e5e4e2"]
  ]);
  
  var data = google.visualization.arrayToDataTable([
      ['Genre', 'Fantasy & Sci Fi', 'Romance', 'Mystery/Crime', 'General',
       'Western', 'Literature', { role: 'annotation' } ],
      ['2010', 10, 24, 20, 32, 18, 5, ''],
      ['2020', 16, 22, 23, 30, 16, 9, ''],
      ['2030', 28, 19, 29, 30, 12, 13, '']
    ]);

  var options = {
    width: 600,
    height: 400,
    legend: { position: 'top', maxLines: 3 },
    bar: { groupWidth: '75%' },
    hAxis: {
        minValue: 0,	
        ticks: [0, .2, .4, .6, .8, 1]
    },
    isStacked: 'percent'
  };
  
  var chart = new google.visualization.BarChart(document.getElementById("chart_div"));
  chart.draw(data, options);
}
</script>
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-chart-area"></i> Area Chart Example
	</div>
	<div class="card-body">
		<div class="chartjs-size-monitor">
			<div class="chartjs-size-monitor-expand">
				<div class=""></div>
			</div>
			<div class="chartjs-size-monitor-shrink">
				<div class=""></div>
			</div>
		</div>
		<!-- Google Chart Canvas -->
		<div id="chart_div"></div>
	</div>
	<div class="card-footer small text-muted">Updated yesterday
		at 11:59 PM</div>
</div>