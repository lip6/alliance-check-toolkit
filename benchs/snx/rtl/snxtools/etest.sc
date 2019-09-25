int edge[2];
int edgeDetect() {
	edge[1]=edge[0];
	if((edge[0]==0)&&(edge[1]==1)) return 1;
	return 0;
}
