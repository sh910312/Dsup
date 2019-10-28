
	<div style="border: black solid 1px;">
		<div>
			<div id="container-for-icon-image" style="display:inline-block; border: black solid 1px;">
				<img src="./resources/images/sql/DBread.png" style="width: 50px; height: 50px;"></img>
			</div>
			<div style="display:inline-block;">
				<div id="container-for-icon-names" style="border: black solid 1px;">
					<div style="display:inline-block; font-weight: bold;">Name :</div>
					<div id="dbread-name" style="display:inline-block;"></div>
				</div>
				<div style="border: black solid 1px;">
					<div style="display:inline-block; font-weight: bold;">Key :</div>
					<div id="dbread-key" style="display:inline-block;"></div>
				</div>
			</div>
		</div>
		<div id="container-for-icon-info">
			<div style="border: black solid 1px;">
				<div id="table-list">Table List</div>
			</div>
			<div style="border: black solid 1px;"> 
				<div>Query Statement</div>
				<div style="height: 100px;">
					<textarea id="sql-statement" style="width: 80%; height: 80px;"></textarea>
				</div>
			</div>
		</div>
		<div id="apply-container" class="container">
			<div style="display: inline-block;">
				<button id="dbread-apply" onclick="controller.apply('DBread');">Apply</button>
			</div>
			<div style="display: inline-block;">
				<button id="dbread-cancel" onclick="">Cancel</button>
			</div>
		</div>
	</div>