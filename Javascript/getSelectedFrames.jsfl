//タイムライン上で選択されているフレームオブジェクトとレイヤーオブジェクトを全て返す
function getSelectedFrames(_timeLine){
	var selectedIndexArr = getSelectedFrameIndexs(_timeLine);
	var targertArr = []
	for(var i=0;i<selectedIndexArr.length;i++){
		targertArr.push(getSelectedLayerInFrames(selectedIndexArr[i]))
	}
	return targertArr
}

//レイヤーとフレームのインデックス値をレイヤーオブジェクトとフレームオブジェクトに直してまとめてオブジェトで返す。
function getSelectedLayerInFrames(_targetLayerArray){
	var targetLayer = timeLine.layers[_targetLayerArray[0]]
	var startFrameIndex =  _targetLayerArray[1]
	var endFrameIndex =  _targetLayerArray[2]
	var frameArr = []
	for(var i =startFrameIndex;i<endFrameIndex;i++){
		var selectedFrame = targetLayer.frames[i]
		if(i == selectedFrame.startFrame)frameArr.push(selectedFrame);//キーフレームかどうか調べる
	}
	return {layer:targetLayer,frames:frameArr};
}

//特定のタイムラインから選択されているレイヤーとフレームのインデックスを返す
function getSelectedFrameIndexs(_timeLine){
	var selectFramesArray = _timeLine.getSelectedFrames()
	var sfaLength = selectFramesArray.length/3;
	var sliceArr =[];
	for(var i =1;i<=sfaLength;i++){
		sliceArr[i-1]= selectFramesArray.slice((i-1)*3,3*i);
		//fl.trace(targetIndex)
	}
	return sliceArr
}
