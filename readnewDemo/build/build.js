'use strict'
require('./check-versions')()

process.env.NODE_ENV = 'production'

const ora = require('ora')
const rm = require('rimraf')
const path = require('path')
const chalk = require('chalk')
const webpack = require('webpack')
const config = require('../config')
const webpackConfig = require('./webpack.prod.conf')
const fs = require('fs')
const fixStaticPath = require('./fix-static-path');

const spinner = ora('building for production...')
spinner.start()

process.env.ASSETS_PATH = config.build.assetsPublicPath
const isPC = process.env.npm_lifecycle_event.includes('-pc');

rm(path.join(config.build.assetsRoot, ''), err => {
    if (err) throw err
    webpack(webpackConfig, (err, stats) => {
        spinner.stop()
        if (err) throw err
        process.stdout.write(stats.toString({
            colors: true,
            modules: false,
            children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
            chunks: false,
            chunkModules: false
        }) + '\n\n')

        fixStaticPath();

        if (stats.hasErrors()) {
            console.log(chalk.red('  Build failed with errors.\n'))
            process.exit(1)
        }

        console.log(chalk.cyan('  Build complete.\n'))
        console.log(chalk.yellow(
            '  Tip: built files are meant to be served over an HTTP server.\n' +
            '  Opening index.html over file:// won\'t work.\n'
        ))

        /**
         * 打包完成后，如果是APP删除resource/pt文件夹
         */
        if (!isPC) {
            rm(path.join(config.build.assetsRoot, config.build.assetsSubDirectory, 'pt'), err => {
            })
            rm(path.join(config.build.assetsRoot, config.build.assetsSubDirectory, 'library'), err => {
            })
            rm(path.join(config.build.assetsRoot, config.build.assetsSubDirectory, 'theme'), err => {
            })
            rm(path.join(config.build.assetsRoot, config.build.assetsSubDirectory, 'bootstrap'), err => {
            })
            //复制resonrce/fonts到resource/css/resource/fonts
            // function syncFiles(src, target) {
            //     fs.readdir(src, function (err, paths) {
            //         if (err) {
            //             console.log('读取文件夹出错')
            //         }
            //         paths.map(_p => {
            //             // 如果是文件夹
            //             if (!/\./.test(_p)) {
            //                 let p = path.join(target, _p);
            //                 // console.log(p)
            //                 if (!fs.existsSync(p)) {
            //                     fs.mkdirSync(p);
            //                 }
            //                 return syncFiles(path.join(src, _p), p)
            //             }

            //             var readstream = fs.createReadStream(path.join(src, _p));
            //             var writestream = fs.createWriteStream(path.join(target, _p));

            //             readstream.pipe(writestream);
            //         })
            //     })
            // }            
            // fs.mkdir(path.join(config.build.assetsRoot, config.build.assetsSubDirectory, 'css','resource'), ()=>{
            //     fs.mkdir(path.join(config.build.assetsRoot, config.build.assetsSubDirectory, 'css','resource','fonts'), ()=>{
            //         syncFiles(path.join(config.build.assetsRoot, config.build.assetsSubDirectory, 'fonts'),path.join(config.build.assetsRoot, config.build.assetsSubDirectory, 'css','resource','fonts'))
            //     });                
            // })            
        }
    })
})
