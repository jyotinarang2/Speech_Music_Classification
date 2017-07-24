function speechMusicData = processData()
basePath = 'C:\Users\jyoti\Desktop\speechmusic data\music_speech\music_speech';
slashType = '/';
music_folder = 'music_wav';
speech_folder = 'speech_wav';
speechMusicData = struct();
music_path = [basePath slashType music_folder];
speech_path = [basePath slashType speech_folder];
music_files = dir(fullfile(music_path,'*.wav'));
speech_files = dir(fullfile(speech_path,'*.wav'));
speechMusicData.music_files = music_files;
speechMusicData.speech_files = speech_files;
end