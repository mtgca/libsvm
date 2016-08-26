% This make.m is for MATLAB and OCTAVE under Windows, Mac, and Unix
function make()
try
	% This part is for OCTAVE
	if (exist ('OCTAVE_VERSION', 'builtin'))
		mex libsvmread.c
		mex libsvmwrite.c
		mex -I.. svmtrain.c ../svm.cpp svm_model_matlab.c
		mex -I.. svmpredict.c ../svm.cpp svm_model_matlab.c
	% This part is for MATLAB
	% Add -largeArrayDims on 64-bit machines of MATLAB
	else
		mex -v GCC='/usr/bin/g++-4.7' GCFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvmread.c
		mex -v GCC='/usr/bin/g++-4.7' CFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvmwrite.c
		mex -v GCC='/usr/bin/g++-4.7' CFLAGS="\$CFLAGS -std=c99" -I.. -largeArrayDims svmtrain.c ../svm.cpp svm_model_matlab.c
		mex -v GCC='/usr/bin/g++-4.7' CFLAGS="\$CFLAGS -std=c99" -I.. -largeArrayDims svmpredict.c ../svm.cpp svm_model_matlab.c
	end
catch err
	fprintf('Error: %s failed (line %d)\n', err.stack(1).file, err.stack(1).line);
	disp(err.message);
	fprintf('=> Please check README for detailed instructions.\n');
end
