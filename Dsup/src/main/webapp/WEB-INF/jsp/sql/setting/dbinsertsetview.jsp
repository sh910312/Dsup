<div style="border: black solid 1px;">
	<div id="container-for-icon-image"
		style="display: inline-block; border: black solid 1px;">
		<img src="./resources/images/sql/DBinsert.png" style="width: 50px; height: 50px;"></img>
	</div>
	<div style="display: inline-block;">
		<div id="container-for-icon-names">
			<div style="display: inline-block; font-weight: bold;">Name :</div>
			<div id="dbinsert-name" style="display: inline-block;"></div>
		</div>
		<div>
			<div style="display: inline-block; font-weight: bold;">Key :</div>
			<div id="dbinsert-key" style="display: inline-block;"></div>
		</div>
	</div>
</div>
<div style="border: black solid 1px; display:flex;">
	<div style="margin-right: 15px">
		<div style="font-weight: bold;">Excution Mode</div>
		<div>
			<select id="dbinsert-mode" name="dbinsert-select" class="dbinsert-select">
				<option selected="selected">Insert</option>
				<option>Update</option>
				<option>Delete</option>
			</select>
		</div>
	</div>
	<div style="margin-right: 15px">
		<div style="font-weight: bold;">Target Table</div>
		<div>
			<select id="target_table_list" name="dbinsert-select" class="dbinsert-select">
				<option>Choice Table</option>
			</select>
		</div>
	</div>
</div>
<div id="dbinsert-contents-container" style="border: black solid 1px; display:flex;">
	<div style = "margin-right:15px">
		<div style="font-weight: bold;">Input Table Columns</div>
		<div class="child-data-table-div">
			<table id="dbinsert-table" border=1>
				<tr>
					<th>Input Col</th>
					<th>Data Type</th>
				</tr>
			</table>
		</div>
	</div>
	<div>
		<div style="font-weight: bold;">Target Table Columns</div>
		<div class="child-data-table-div">
			<table id="dbinsert-target-table" border=1>
				<tr>
					<th>Data Type</th>
					<th>Target Col</th>
					<th>=</th>
					<th>Input Col</th>
				</tr>
			</table>
		</div>
	</div>
</div>
<div style="border: black solid 1px; display:flex;">
	<div style="display:inline-block;">
		<input type="radio" name="dbinsert-add-type" class="dbinsert-add-type" value="Manual" checked="checked">Manual
	</div>
	<div style="display:inline-block;">
		<input type="radio" name="dbinsert-add-type" class="dbinsert-add-type" value="Auto">Auto
	</div>
	<div>
		<button onclick="controller.add('DBinsert')">Add</button>
	</div>
</div>
<div style="border: black solid 1px;">
	<div style="font-weight: bold;">Matching Columns</div>
	<div>
		<table id="dbinsert-execution-table" border=1>
			<tr>
				<th>Target Col</th>
				<th>=</th>
				<th>Input Col</th>
		   </tr>
		</table>
	</div>
</div>
<div style="border: black solid 1px;">
	<div style="font-weight: bold;">Where Statement</div>
	<div>
		<table id="dbinsert-whereStmt-table" border=1>
			<tr>
				<th>Target Col</th>
				<th>=</th>
				<th>Input Col</th>
			</tr>
			<tr>
				<td>
					<select id="where-stmt-target-select" name="where-stmt-select" class="where-stmt-select" disabled="disabled"></select>
				</td>
				<td>=</td>
				<td>
					<select id="where-stmt-input-select" name="where-stmt-select" class="where-stmt-select" disabled="disabled"></select>
				</td>
			</tr>
		</table>
	</div>
</div>
<div style="border: black solid 1px; display: flex;">
	<div>
		<button onclick="controller.apply('DBinsert')">Apply</button>
	</div>
	<div>
		<button>Reset</button>
	</div>
</div>