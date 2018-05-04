<template>
  <div class="header">
		<div class="header-warpper">
			<i class="menu iconfont icon-sortlight" ></i>
			<div class="centermenu">
				<router-link tag="i" to="">
					<i class="music iconfont icon-musicfill"></i>
				</router-link>
				<router-link tag="i" to="">
					<i class="find iconfont icon-discover"></i>
				</router-link>
				<router-link tag="i" to="">
					<i class="community iconfont icon-friend_light"></i>
				</router-link>
			</div>
				<i class="search iconfont icon-search_light"></i>
		</div>
	</div>
</template>

<script>
export default {
  data () {
    return {

    }
  },
  methods:{
    
  }
  
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang='less' scoped>
	@import  '../../../static/font-icon/iconfont.css';
	@import  '../../common/common.less';
		.header{
		position:fixed;
		top:0;
		left:0;
		right:0;
		height:50px;
		z-index:10;
        background:@primarycolor;
		.header-warpper{
			height:100%;
			background:@primarycolor;
			display:flex;
			align-items:center;
			justify-content:space-between;
			.menu,.search{
				color:#fff;
				font-size:26px;
				padding:10px 15px;
			}
			.centermenu{
				font-size:24px;
				.iconfont{
						font-size:30px;
						padding:10px 15px;
						color:#fff;
				}
				i{
					margin:0 5px;
					color:#eee;
					.router-link-active{
						color:@link_active;
					}
					.active{
						color:#4AE0A8;
					}
					.music{
						font-size:22px;
					}
				}
			}
			.counter{
				position:absolute;
				background:green;
				width:600px;
				height:150px;
				color:#fff;
				font-size:20px;
				top:0;
				left:120px;
				p{
					height:30px;
					line-height:30px;
				}
			}
		}
		}
	
		
</style>
