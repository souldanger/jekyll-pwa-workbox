try{self["workbox:window:5.0.0-alpha.0"]&&_()}catch(t){}const t=(t,s)=>new Promise(i=>{let e=new MessageChannel;e.port1.onmessage=(t=>i(t.data)),t.postMessage(s,[e.port2])});try{self["workbox:core:5.0.0-alpha.0"]&&_()}catch(t){}class s{constructor(){this.promise=new Promise((t,s)=>{this.resolve=t,this.reject=s})}}class i{constructor(){this.t={}}addEventListener(t,s){this.s(t).add(s)}removeEventListener(t,s){this.s(t).delete(s)}dispatchEvent(t){t.target=this,this.s(t.type).forEach(s=>s(t))}s(t){return this.t[t]=this.t[t]||new Set}}const e=(t,s)=>new URL(t,location).href===new URL(s,location).href;class n{constructor(t,s){Object.assign(this,s,{type:t})}}const h=200,a=6e4;class o extends i{constructor(t,i={}){super(),this.i=t,this.h=i,this.o=0,this.l=new s,this.g=new s,this.u=new s,this.m=this.m.bind(this),this.v=this.v.bind(this),this.p=this.p.bind(this),this._=this._.bind(this)}async register({immediate:t=!1}={}){t||"complete"===document.readyState||await new Promise(t=>addEventListener("load",t)),this.C=Boolean(navigator.serviceWorker.controller),this.W=this.L(),this.S=await this.B(),this.W&&(this.R=this.W,this.g.resolve(this.W),this.u.resolve(this.W),this.P(this.W),this.W.addEventListener("statechange",this.v,{once:!0}));const s=this.S.waiting;return s&&e(s.scriptURL,this.i)&&(this.R=s,Promise.resolve().then(()=>{this.dispatchEvent(new n("waiting",{sw:s,wasWaitingBeforeRegister:!0}))})),this.R&&this.l.resolve(this.R),this.S.addEventListener("updatefound",this.p),navigator.serviceWorker.addEventListener("controllerchange",this._,{once:!0}),"BroadcastChannel"in self&&(this.T=new BroadcastChannel("workbox"),this.T.addEventListener("message",this.m)),navigator.serviceWorker.addEventListener("message",this.m),this.S}get active(){return this.g.promise}get controlling(){return this.u.promise}async getSW(){return this.R||this.l.promise}async messageSW(s){const i=await this.getSW();return t(i,s)}L(){const t=navigator.serviceWorker.controller;if(t&&e(t.scriptURL,this.i))return t}async B(){try{const t=await navigator.serviceWorker.register(this.i,this.h);return this.U=performance.now(),t}catch(t){throw t}}P(s){t(s,{type:"WINDOW_READY",meta:"workbox-window"})}p(){const t=this.S.installing;this.o>0||!e(t.scriptURL,this.i)||performance.now()>this.U+a?(this.k=t,this.S.removeEventListener("updatefound",this.p)):(this.R=t,this.l.resolve(t)),++this.o,t.addEventListener("statechange",this.v)}v(t){const s=t.target,{state:i}=s,e=s===this.k,a=e?"external":"",o={sw:s,originalEvent:t};!e&&this.C&&(o.isUpdate=!0),this.dispatchEvent(new n(a+i,o)),"installed"===i?this.D=setTimeout(()=>{"installed"===i&&this.S.waiting===s&&this.dispatchEvent(new n(a+"waiting",o))},h):"activating"===i&&(clearTimeout(this.D),e||this.g.resolve(s))}_(t){const s=this.R;s===navigator.serviceWorker.controller&&(this.dispatchEvent(new n("controlling",{sw:s,originalEvent:t})),this.u.resolve(s))}m(t){const{data:s}=t;this.dispatchEvent(new n("message",{data:s,originalEvent:t}))}}export{o as Workbox,t as messageSW};
//# sourceMappingURL=workbox-window.prod.mjs.map
