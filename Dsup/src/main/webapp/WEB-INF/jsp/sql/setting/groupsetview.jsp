<div>
	<div style="border: black solid 1px;">
		<div id="container-for-icon-image"
			style="display: inline-block; border: black solid 1px;">
			<img src="./resources/images/sql/Group.png" style="width: 50px; height: 50px;"></img>
		</div>
		<div style="display: inline-block;">
			<div id="container-for-icon-names">
				<div style="display: inline-block; font-weight: bold;">Type :</div>
				<div id="group-name" style="display: inline-block;"></div>
			</div>
			<div>
				<div style="display: inline-block; font-weight: bold;">Key :</div>
				<div id="group-key" style="display: inline-block;"></div>
			</div>
		</div>
	</div>
	<div>
		<div style="font-weight: bold;">Group Mode</div>
		<div style="display:flex;">
			<div style="margin-right: 20px;">
				<input type="radio" name="groupType" value="ORIGINAL" checked="checked">Original 
			</div>
			<div>
				<input type="radio" name="groupType" value="ADD COL">Expand Column
			</div> 
		</div>
	</div>
	<div>
		<div style="border: black solid 1px; display: flex;">
			<div class="container-for-group-setting" style="margin-right: 20px">
				<div style="font-weight: bold;">Key Columns</div>
				<div class="container-for-group-setting" style="margin-right: 20px">
					<div class="child-data-table-div">
						<table id="group-table" border="1"></table>
					</div>
				</div>
			</div>
			<div style="display:none;">
				<div style="font-weight: bold;">Operaters</div>
				<div>
					<div id="group-operaters-div" class="operaters-div">
						<div><span>MIN</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>MAX</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>AVG</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>SUM</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
					</div>
				</div>
			</div>		
		</div>
	</div>
	<div> 
		<div style="font-weight: bold;">New Column</div>
		<div class="container-for-group-setting" style="border: black solid 1px; border: black solid 1px;">
			<div style="display: flex;">
				<div style="font-weight: bold; margin-right: 20px;">Col Name</div>
				<div>
					<input id="group-col-name"/>
				</div>
			</div>
			<div class="container-for-data-list" style="display:flex;">
				<div style="font-weight: bold; margin-right: 20px;">Expression</div>
				<div>
					<textarea id='group-expression' rows="" cols=""></textarea>
				</div>
			</div>
		</div>
	</div>
	<div>
		<button onclick="controller.add('Group')">Add</button>
	</div>
	<div>
		<div style="font-weight: bold;">Add Columns</div>
		<div class="expression-result-table-div">
			<table id="add-col-expression-table" border="1">
				<tr>
					<td>Column</td>
					<td>Expression</td>
					<td>Type</td>
				</tr>
			</table>
		</div>
	</div>
	<div>
		<div style="display: inline-block;">
			<button onclick="controller.apply('Group')">Apply</button>
		</div>
		<div style="display: inline-block;">
			<button>Reset</button>
		</div>
	</div>
</div>