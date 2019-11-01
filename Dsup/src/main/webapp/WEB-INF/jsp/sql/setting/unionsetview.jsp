<div>
	<div id="container-for-icon-info" style="border: black solid 1px;">
		<div id="container-for-icon-image" style="display: inline-block;">
			<img src="./resources/images/sql/Union.png" style="width: 50px; height: 50px;"></img>
		</div>
		<div id="container-for-icon-names" style="display: inline-block;">
			<div>
				<div style="display: inline-block; font-weight: bold;">Type :</div>
				<div id="union-momo-type" style="display: inline-block;"></div>
			</div>
			<div>
				<div style="display: inline-block; font-weight: bold;">Key :</div>
				<div id="union-momo-key" style="display: inline-block;"></div>
			</div>
		</div>
	</div>
	<div style="border: black solid 1px;">
		<div style="display: inline-block; margin-right: 100px;">
			<div style="font-weight: bold;">Master Table</div>
			<div class="master-select-div">
				<select id="union-master-select">
				</select>
			</div>
		</div>
		<div style="display: inline-block;">
			<div style="font-weight: bold;">Union Type</div>
			<div class="type-select-div">
				<select id="union-type-select">
					<option value="UNION">Union</option>
					<option value="UNION ALL">Union All</option>
					<option value="MINUS">Minus</option>
					<option value="INTERSECT">Intersect</option>
				</select>
			</div>
		</div>
	</div>
	<div id="union-contents-container" style="border: black solid 1px; display:flex">
		<div class="container-for-union-setting" >
			<div style="display:flex">
				<div id="union-master-mark-div-1" style="font-weight: bold;"><p style="margin:0px 10px 0px 10px;">Master</p></div>
				<div id="union-dataTableName-1" class="union-dataTableName"></div>
			</div>
			<div class="child-data-table-div">
				<table id="union-dataTable-1" border="1">
					<tr>
						<th>Columns</th>
						<th>Data Type</th>
					</tr>				
				</table>
			</div>
		</div>
		<div class="container-for-union-setting">
			<div style="display:flex">
				<div id="union-master-mark-div-2" style="font-weight: bold;"><p style="margin:0px 10px 0px 10px;">Slave</p></div>
				<div id="union-dataTableName-2" class="union-dataTableName"></div>
			</div>
			<div class="child-data-table-div">
				<table id="union-dataTable-2" border="1">
					<tr>
						<th>Columns</th>
						<th>Data Type</th>
					</tr>		
				</table>
			</div>
		</div>
	</div>
	<div>
		<div style="display:inline-block;">
			<input type="radio" name="union-add-type" class="union-add-type" value="Manual" checked="checked">Manual
		</div>
		<div style="display:inline-block;">
			<input type="radio" name="union-add-type" class="union-add-type" value="Auto">Auto
		</div>
		<div style="display:inline-block;">
			<button onclick="controller.add('Union')">Add</button>
		</div>
	</div>
	<div>
		<table id="union-match-table" border="1">
			<thead>	
				<tr>
					<th>Column</th>
					<th>matching Columns</th>
					<th>Type</th>
				</tr>
			</thead>
		</table>
	</div>
	<div>
	<div style="display: inline-block;">
		<button onclick="controller.apply('Union')">Apply</button>
	</div>
	<div style="display: inline-block;">
		<button>Reset</button>
	</div>
</div>
</div>