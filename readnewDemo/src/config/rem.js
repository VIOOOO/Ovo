
import { systemOs } from '@/config/env'

(function (doc, win) {
    var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
        recalc = systemOs == 'wap' ? function () {
            var clientWidth = docEl.clientWidth;

            if (window.orientation == 180 || window.orientation == 0) {
                clientWidth = docEl.clientWidth;
            }
            if (window.orientation == 90 || window.orientation == -90) {
                clientWidth = docEl.clientHeight;
            }

            if (!clientWidth) return;
            docEl.style.fontSize = 20 * (clientWidth / 320) + 'px';
        } : function () {
            docEl.style.fontSize = '24px';
        };
    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
    doc.addEventListener('DOMContentLoaded', recalc, false);
    setInterval(recalc, 3000)
})(document, window);