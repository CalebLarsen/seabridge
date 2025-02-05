use CTypes;

extern proc malloc(n: c_size_t): c_ptr(uint(8));
extern proc free(p: c_ptr(uint(8)));

export proc day_chapel_9_chpl(so_far: c_ptr(uint(8))): c_ptr(uint(8))  {
	var today: string = "Nine processors sharing\n";
	var so_far_len = strLen(so_far);
	var today_len = today.size;
	var ret = malloc((so_far_len + today_len + 1):c_size_t);
	for i in 0..#so_far_len {
		ret[i] = so_far[i];
	}
	for i in 0..#today_len {
		ret[i+so_far_len] = today.byte(i);
	}
	ret[so_far_len + today_len] = 0x00;
	free(so_far);
	return ret;
}
