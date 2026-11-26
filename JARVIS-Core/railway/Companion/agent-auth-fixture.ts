if(Bun.env.CI!=='true'||Bun.env.DJO2_WRAPPER_TEST!=='1')throw Error('CI fixture only');
Bun.serve({hostname:'127.0.0.1',port: Number(Bun.env.PORT||3000),fetch(){return new Response('fixture');}});
