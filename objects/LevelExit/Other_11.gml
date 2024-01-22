// uhhh

alarm[0] = -1;
animator_set_animation(animator, "unite", anim_unite_complete);
if (!audio_is_playing(snd_good) && !sound_played) {
	audio_play_sound(snd_good, 10, false);
	sound_played = true;
}