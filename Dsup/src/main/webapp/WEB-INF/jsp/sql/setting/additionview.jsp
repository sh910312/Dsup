<div>
	<div style="border: black solid 1px;">
		<div id="container-for-icon-image"
			style="display: inline-block; border: black solid 1px;">
			<img src="./resources/images/sql/Addition.png" style="width: 50px; height: 50px;"></img>
		</div>
		<div style="display: inline-block;">
			<div id="container-for-icon-names">
				<div style="display: inline-block; font-weight: bold;">Name :</div>
				<div id="addition-name" style="display: inline-block;"></div>
			</div>
			<div>
				<div style="display: inline-block; font-weight: bold;">Key :</div>
				<div id="addition-key" style="display: inline-block;"></div>
			</div>
		</div>
	</div>
	<div id="addition-add-col-conainer" style="display: block;">
		<div style="border: black solid 1px; display: flex; ">
			<div class="container-for-addition-setting" style="margin-right: 20px">
				<div style="font-weight: bold;">Columns</div>
				<div class="child-data-table-div">
					<table id="additon-table" border="1"></table>
				</div>
			</div>
			<div class="container-for-addition-setting">
				<div style="font-weight: bold;">Operaters</div>
				<div>
					<div id="additon-operaters-div" class="operaters-div" style="display:none;">
						<div><span>MIN</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>MAX</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>AVG</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>SUM</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div class="container-for-addition-setting"
				style="display: inline-block; font-weight: bold; border: black solid 1px;">
				<div style="font-weight: bold; border: black solid 1px;">
					<div style="display: inline-block;">Col Name</div>
					<div style="display: inline-block;">
						<input type="text" id="addition-col-name"/>
					</div>
				</div>
				<div class="container-for-data-list" style="display:flex; font-weight: bold; border: black solid 1px;">
					<div>Expression</div>
					<div>
						<textarea id='addition-expression' rows="" cols=""></textarea>
					</div>
				</div>
			</div>
		</div>
		<div>
			<button onclick="controller.add('Addition')">Add</button>
		</div>
		<div>
			<div style="font-weight: bold;">Add Columns</div>
			<div class="expression-result-table-div">
				<table id="add-col-expression-table" border="1">
					<tr>
						<td>Column</td>
						<td>Expression</td>
					</tr>
				</table>
			</div>
		</div>
		<div>
			<div style="display: inline-block;">
				<button onclick="controller.apply('Addition')">Apply</button>
			</div>
			<div style="display: inline-block;">
				<button>Reset</button>
			</div>
		</div>
	</div>
</div>