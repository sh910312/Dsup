
<div id="sidebar-container" style="border: 1px solid black">
	<div id="container-for-icon-info" style="display:flex">
		<div id="container-for-icon-image" style="margin-right: 20px;">
			<img src="./resources/images/sql/Join.png" style="width: 50px; height: 50px;"></img>
		</div>
		<div id="container-for-icon-names">
			<div>
				<div style="display:inline-block; font-weight: bold;">Type : </div>
				<div id="join-momo-type" style="display:inline-block;"></div>
			</div>
			<div>
				<div style="display:inline-block; font-weight: bold;">Key : </div>
				<div id="join-momo-key" style="display:inline-block;"></div>
			</div>
		</div>
	</div>
	<div id="container-for-join-type" style="display:flex; border: black solid 1px;">
		<div>
			<input type="radio" name="joinType" value="INNER JOIN" checked="checked">Inner Join
		</div>
		<div>
			<input type="radio" name="joinType" value="RIGHT OUTER JOIN">Right Outer Join 
		</div>
		<div>
			<input type="radio" name="joinType" value="LEFT OUTER JOIN">Left Outer Join
		</div> 
	</div>
	<div id="join-contents-container" style="display:flex; border: black solid 1px;">
		<div class="container-for-join-setting"> 
			<div id="join-dataTableName-1" class="join-dataTableName" style="font-weight: bold; margin-right: 20px;"></div>
			<div class="child-data-table-div">
				<table id="join-dataTable-1" border="1">
					<tr>
						<th>Column Name</th>
						<th>Type</th>
					</tr>
				</table>
			</div>
		</div>
		<div class="container-for-join-setting"> 
			<div id="join-dataTableName-2" class="join-dataTableName" style="font-weight: bold;"></div>
			<div class="child-data-table-div">
				<table id="join-dataTable-2" border="1">
					<tr>
						<th>Column Name</th>
						<th>Type</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div id="container-for-join-button">
		<button onclick="controller.add('Join')">Join</button>
	</div>
	<div id="container-for-join-key" style="border: black solid 1px;">
		<div style="font-weight: bold;">Join Expression</div>
		<div style = "min-height: 10vh;">
			<ul id="join-expression" style="margin: 0px; padding-inline-start: 30px;">
			</ul>
		</div>
	</div>
	<div id="container-for-cancel-key">
		<div>
			<input type="checkbox" name="productType" value="product">Catesian Product
		</div>
		<div>
			<button>Delete</button>
		</div>
	</div>
	<div id="container-for-apply" style = "border: black solid 1px;">
		<div style="display:inline-block;">
			<button onclick="controller.apply('Join')">Apply</button>
		</div>
		<div style="display:inline-block;">
			<button>Cancel</button>
		</div>
	</div>
</div>