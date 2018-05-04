<template>
  <div class="bottom-bar" >
		<div class="music-info">
			<img class="music-pic" :src="musicImage" alt="">
			<div class="music-detail">
				<p class="music-name">玫瑰花的葬礼</p>
				<p class="music-singer">许嵩</p>
			</div>
		</div>
		<div class="playpause" >
			<i class="iconfont icon-playfill"></i>
		</div>
		<i class="music-list iconfont icon-sort"></i>
	</div>
</template>
<script>
export default {
  data () {
    return {
        musicImage:'../../../static/images/swiper/xusong.jpg'
    }
  }
  
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang='less' scoped>
@import  '../../../static/font-icon/iconfont.css';
@import  '../../common/common.less';
.bottom-bar{
    position:fixed;
    z-index:9;
	background:#fff;
	bottom:0;
	height:50px;
	padding:5px;
	box-sizing:border-box;
	left:0;
	right:0;
	display:flex;
    align-items: center;
    .music-info{
        position:relative;
		flex:1 1 auto;
		height:100%;
        display:flex;
        .music-pic{
            flex:0 0 36px;
			width:40px;
			height:40px;
        }
        .music-detail{
            font-size: 24px;
            flex:1 1 auto;
			padding: 0 10px;
			display:flex;
			flex-direction:column;
            justify-content:space-around;
            text-align: left;
            @media screen and (max-width: 414px){
                p{
                    max-width:250px;
                }	
            }
			@media screen and (max-width: 375px){
                p{
                    max-width:210px;
                }
            }
			@media screen and (max-width: 320px){
                 p{
                    max-width:160px;
                }
            }
			@media screen and (min-width: 768px){
                p{
                    max-width:580px;
                }
            }
			p{
                width:100%;
				margin:0;
				text-overflow:ellipsis;
				white-space:nowrap;
                overflow:hidden;
                &.music-name{
                    font-size:14px;
					font-weight:400;
					color:#333;
					padding:2px 0;
                }
                &.music-singer{
                    color:#aaa;
					font-size:10px;
					font-weight:400;
					padding:2px 0;
                }   
            }	
        }	
    } 
    .playpause{
        border:2px solid #999;
		border-radius:50%;
		width:24px;
		height:24px;
        position:relative;
        &:active{
            background:@list_active;
        }
        i{
            display:block;
			position:absolute;
			top:65%;
			left:55%;
			transform:translate3d(-50%,-50%,0);
			width:22px;
			height:22px;
			font-size:14px;
			color:#333;
            text-align:center;
            &.icon-pause{
                left:50%;
				font-size:18px;
				color:@primarycolor;
            }
        }
    }	
    .music-list{
        margin-left:10px;
		display:block;
		flex:0 0 36px;
		width:36px;
		height:100%;
		line-height:36px;
		text-align:center;
		font-size:26px;
        color:#999;
        &:active{
           background:@list_active;
        }
    }
}



</style>
